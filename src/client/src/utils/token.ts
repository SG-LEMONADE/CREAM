export const getToken = () => {
	return (
		typeof window !== "undefined" && window.localStorage.getItem("creamToken")
	);
};

export const setToken = (token: string) => {
	typeof window !== "undefined" &&
		window.localStorage.setItem("creamToken", token);
};
