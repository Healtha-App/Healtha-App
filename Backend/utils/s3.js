const getSignedUrl = require('@aws-sdk/s3-request-presigner').getSignedUrl;
const { GetObjectCommand } = require("@aws-sdk/client-s3");

const {
	S3Client,
	PutObjectCommand
} = require("@aws-sdk/client-s3");


const uploadToS3 = (file) => {
	const bucketName = process.env.BUCKET_NAME;
	const bucketRegion = process.env.REGION;
	const accessId = process.env.AWS_ACCESS_ID;
	const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY;

	const s3 = new S3Client({
		credentials: {
			accessKeyId: accessId,
			secretAccessKey: secretAccessKey,
		},
		region: bucketRegion,
	});

	let fileName = file.originalname;
	let params = {
		Bucket: bucketName,
		Key: fileName,
		Body: file.buffer,
		ContentType: file.mimetype,
		ContentEncoding: 'base64',
		ACL: 'public-read'
	};

	var command = new PutObjectCommand(params);
	s3.send(command);

	var command = new GetObjectCommand(params);
	image_url = getSignedUrl(
		s3,
		command,
		{ expiresIn: 86400 }
	);

	return image_url;
}

module.exports = {
	uploadToS3
}