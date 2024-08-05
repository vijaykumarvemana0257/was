// Import the AWS SDK
const AWS = require('aws-sdk');

// Configure the AWS SDK
AWS.config.update({ region: 'ca-central-1' });

// Create an SQS service object
const sqs = new AWS.SQS({ apiVersion: '2012-11-05' });

const queueUrl = "https://sqs.us-east-2.amazonaws.com/507527568727/sqs-standard-MyQueue-dUflu7pAXbTp";

const params = {
  QueueUrl: queueUrl,
  MessageBody: "Hello Ruby!",
  DelaySeconds: 1,
  MessageAttributes: {
    "Fruit": {
      DataType: "String",
      StringValue: "Apple"
    }
  }
};

// Send the message
sqs.sendMessage(params, (err, data) => {
  if (err) {
    console.error("Error", err);
  } else {
    console.log("Success", data.MessageId);
  }
});
