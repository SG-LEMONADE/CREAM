import axios from "axios";
import { getToken } from "./token";

export const validateUser = async (): Promise<number> => {
	const token = getToken("accessToken");
	if (!token) {
		console.warn("TOKEN DOESN'T EXISTS. There is No token.");
		return;
	}
	try {
		const res = await axios.post(
			`${process.env.END_POINT_USER}/users/validate`,
			{},
			{
				headers: {
					Authorization: `Bearer ${token}`,
				},
			},
		);
		if (res.data === "") {
			// user validation OK.
			return 1;
		} else {
			console.error("TOKEN is not valid!");
			return;
		}
	} catch (e) {
		console.error("ERROR in `users/validate/");
		console.log(e.response);
		return;
	}
};
