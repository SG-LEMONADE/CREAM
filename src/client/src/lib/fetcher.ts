import axios from "axios";

export const fetcher = async (url: string) => {
	const res = await axios.get(url, {
		headers: {
			userId: "1",
		},
	});
	const data = await res.data;
	console.log("fetcher로 가져온 데이터는, ");
	console.log(data);
	return data;
};
