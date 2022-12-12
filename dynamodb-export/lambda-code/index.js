const AWS = require('aws-sdk');

exports.handler = async (event) => {
    console.log('Start exporting')
    const dynamodb = new AWS.DynamoDB();

    const todayDate = new Date().toISOString().slice(0, 10);
    const formattedDate = todayDate.replace(/-/g, "/");

    const params = {
        S3Bucket: process.env.BUCKET_NAME,
        TableArn: process.env.TABLE_ARN,
        ExportFormat: 'DYNAMODB_JSON',
        S3Prefix: `${formattedDate}/`
    }

    try {
        const exportResponse = await dynamodb.exportTableToPointInTime(params).promise();
        console.log(`successfully extract data ${exportResponse}`)
    } catch (err) {
        console.log(err)
    }
};