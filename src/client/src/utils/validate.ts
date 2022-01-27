export const validateEmailFormat = (email: string) => {
	const re =
		/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;

	return re.test(email);
};

export const validatePwdFormat = (pwd: string) => {
	const re =
		/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&^]{8,}$/;
	return re.test(pwd);
};
