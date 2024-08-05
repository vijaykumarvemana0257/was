const { SQSClient, ReceiveMessageCommand, DeleteMessageCommand } = require("@aws-sdk/client-sqs");

const client = new SQSClient({ region: 'us-east-2' });

const queueUrl = "https://sqs.us-east-2.amazonaws.com/507527568727/sqs-standard-MyQueue-dUflu7pAXbTp";

const receiveParams = {
  QueueUrl: queueUrl,
  AttributeNames: ["All"],
  MaxNumberOfMessages: 1,
  VisibilityTimeout: 1,
  WaitTimeSeconds: 1
};

const receiveMessage = async () => {
  try {
    const data = await client.send(new ReceiveMessageCommand(receiveParams));
    if (data.Messages) {
      for (const message of data.Messages) {
        console.log("Receipt Handle:", message.ReceiptHandle);
        console.log("Message Body:", message.Body);
        console.log("Message Attributes:", message.Attributes);

        const deleteParams = {
          QueueUrl: queueUrl,
          ReceiptHandle: message.ReceiptHandle
        };

        try {
          const deleteData = await client.send(new DeleteMessageCommand(deleteParams));
          console.log("Message Deleted", deleteData);
        } catch (deleteError) {
          console.error("Delete Error", deleteError);
        }
      }
    } else {
      console.log("No messages to receive");
    }
  } catch (err) {
    console.error("Error", err);
  }
};

receiveMessage();
