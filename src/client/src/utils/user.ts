import { customAxios } from "lib/customAxios";

export const validateUser = async (): Promise<number> => {
	const token = window.localStorage.getItem("creamToken");
	if (!token) {
		return;
	}
	try {
		const res = await customAxios.post("/users/validate");
		if (res.data === null) {
			return 1;
		} else {
			return;
		}
	} catch (e) {
		return;
	}
};
