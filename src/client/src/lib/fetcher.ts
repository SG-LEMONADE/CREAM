import axios from "axios";

export const fetcher = async (url: string) => {
	const res = await axios.get(url, {
		headers: {
			userId: "1",
		},
	});
	const data = await res.data;
	console.log(data);
	return data;
};
