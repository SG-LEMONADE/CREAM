import axios from "axios";

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
