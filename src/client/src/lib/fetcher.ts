import axios from "axios";
import { UserInfo } from "context/user";
import { getToken } from "lib/token";
import React, { SetStateAction } from "react";
import { validateUser } from "./user";

export const fetcher = async (url: string) => {
	const res = await axios.get(url);
	const data = await res.data;
	return data;
};

export const fetcherWithToken = async (
	url: string,
	setUser: React.Dispatch<SetStateAction<UserInfo>>,
) => {
	const token = getToken("accessToken");
	if (!token) {
		console.warn("TOKEN DOESN'T EXISTS. There is No token.");
		return;
	}

	console.log("@@@@validation 시작합니다.@@@");
	const validateRes = await validateUser(setUser);
	console.log("결과는, ", validateRes);
	if (!validateRes) return null;

	try {
		const res = await axios.get(url, {
			headers: {
				Authorization: `Bearer ${token}`,
			},
		});
		const data = await res.data;
		return data;
	} catch (e) {
		const response = e.response.data;
		console.log(response);
	}
};
