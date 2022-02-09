import axios from "axios";

export const fetcher = async (url: string) => {
	console.log("🚩🚩🚩🚩🚩🚩🚩🚩");
	console.log(url);
	const res = await axios.get(url, {
		headers: {
			userId: "1",
		},
	});
	const data = await res.data;
	console.log(url, "fetcher로 가져온 데이터는, ");
	console.log(data);
	return data;
};
