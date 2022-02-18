import axios from "axios";
import { getToken, setToken } from "./token";

export const refresh = async (): Promise<number> => {
	let refreshToken = getToken("refreshToken");
	try {
		const res = await axios.post(
			`${process.env.END_POINT_USER}/users/refresh`,
			{
				refreshToken: `Bearer ${refreshToken}`,
			},
		);
		const data = await res.data;
		console.log("REFRESH 완료!!");
		setToken("accessToken", data.accessToken);
		setToken("refreshToken", data.refreshToken);
		return data.userId;
	} catch (e) {
		const response = e.response.data;
		console.error("리프레쉬 토큰 발급 중 에러.");
		if (response.code === -14) return -1;
		console.log(response);
	}
};
