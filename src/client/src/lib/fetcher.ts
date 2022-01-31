import axios from "axios";

export const fetcher = async (url: string) => {
	const res = await axios.get(url);
	console.log(`서버에서 받아온 response는`);
	console.log(res);
	const data = await res.data;
	console.log(`반환된 data는`);
	console.log(data);
	return data;
};
