export const getToken = (type: "acessToken" | "refreshToken") => {
	if (typeof window !== "undefined") {
		return type === "acessToken"
			? window.localStorage.getItem("creamAcessToken")
			: window.localStorage.getItem("creamRefreshToken");
	}
};

export const setToken = (
	type: "acessToken" | "refreshToken",
	token: string,
) => {
	if (typeof window !== "undefined") {
		type === "acessToken" &&
			window.localStorage.setItem("creamAcessToken", token);
		type === "refreshToken" &&
			window.localStorage.setItem("creamRefreshToken", token);
	}
};
