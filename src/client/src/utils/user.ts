import { customAxios } from "lib/customAxios";
import { getToken } from "./token";

export const validateUser = async (): Promise<number> => {
	const token = getToken("acessToken");
	if (!token) {
		console.log("No token");
		return;
	}
	try {
		console.log(token);
		const res = await customAxios.post("/users/validate");
		if (res.data === "") {
			// user validation OK.
			console.log("user 검증 완료!");
			return 1;
		} else {
			console.log("user 검증 실패!");
			return;
		}
	} catch (e) {
		console.log(e);
		console.log(e.response);
		return;
	}
};
