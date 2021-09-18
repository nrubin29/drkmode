/// The secret key used to authenticate admin requests.
const secretKey = String.fromEnvironment('secretKey');

bool get hasSecretKey => secretKey.isNotEmpty;
