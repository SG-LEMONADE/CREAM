export const getToken = (type: "accessToken" | "refreshToken") => {
	if (typeof window !== "undefined") {
		return type === "accessToken"
			? window.localStorage.getItem("creamAccessToken")
			: window.localStorage.getItem("creamRefreshToken");
	}
};

export const setToken = (
	type: "accessToken" | "refreshToken",
	token: string,
) => {
	if (typeof window !== "undefined") {
		type === "accessToken" &&
			window.localStorage.setItem("creamAccessToken", token);
		type === "refreshToken" &&
			window.localStorage.setItem("creamRefreshToken", token);
	}
};
