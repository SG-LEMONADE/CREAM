import React, { SetStateAction } from "react";
import { UserInfo } from "context/user";
import axios from "axios";

import { refresh } from "./refresh";
import { getToken } from "./token";

export const validateUser = async (
	setUser: React.Dispatch<SetStateAction<UserInfo>>,
): Promise<number | boolean> => {
	const token = getToken("accessToken");
	if (!token) {
		console.warn("TOKEN DOESN'T EXISTS. There is No token.");
		return false;
	}
	try {
		const res = await axios.get(
			`${process.env.END_POINT_USER}/users/validate`,
			{
				headers: {
					Authorization: `Bearer ${token}`,
				},
			},
		);
		if (res.data === "") {
			// user validation OK.
			return true;
		} else {
			return false;
		}
	} catch (e) {
		const errResponse = e.response.data;
		if (errResponse.code === -21) {
			const refreshResult = await refresh();
			if (refreshResult < 0) {
				return false;
			} else {
				setUser({ id: refreshResult });
				return true;
			}
		}
	}
};
