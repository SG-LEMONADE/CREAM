import axios from "axios";
import { getToken } from "utils/token";

export const fetcher = async (url: string) => {
	const res = await axios.get(url, {
		headers: {
			userId: "1",
		},
	});
	const data = await res.data;
	console.log(`✅✅✅ ${url}를 통해 데이터 받았습니다! ✅✅✅`);
	console.log(data);
	return data;
};

export const fetcherWithToken = async (url: string) => {
	const token = getToken("accessToken");
	if (!token) {
		console.warn("TOKEN DOESN'T EXISTS. There is No token.");
		return;
	}
	const res = await axios.get(url, {
		headers: {
			Authorization: `Bearer ${token}`,
		},
	});
	const data = await res.data;
	console.log(data);
	return data;
};
