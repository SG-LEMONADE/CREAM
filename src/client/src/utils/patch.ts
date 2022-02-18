import axios from "axios";

import { getToken } from "../lib/token";

export const onPatchUserInfo = async (id: number, data: any) => {
	const token = getToken("accessToken");
	if (!id || !token) {
		return 0;
	}
	try {
		const res = await axios.patch(
			`${process.env.END_POINT_USER}/users/${id}`,
			{ ...data },
			{
				headers: {
					Authorization: `Bearer ${token}`,
				},
			},
		);
		return 1;
	} catch (e) {
		console.error(e);
	}
};
