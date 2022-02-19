import axios from "axios";

import { getToken } from "lib/token";

export const onRegisterTrade = async (
	category: string,
	auction: boolean,
	date: number,
	price: number,
	id: string,
	size: string,
): Promise<boolean | number> => {
	const token = getToken("accessToken");
	console.log(category, auction, date, price, id, size);
	if (auction) {
		// 경매 형식
		try {
			const res = await axios.post(
				`${process.env.END_POINT_PRODUCT}/trades/products/${id}/${size}`,
				{
					price: price,
					requestType: category === "buy" ? `ASK` : `BID`,
					validationDay: date,
				},
				{
					headers: {
						Authorization: `Bearer ${token}`,
					},
				},
			);
			if (res.status === 200) return true;
			else return false;
		} catch (e) {
			const errResponse = e.response.data;
			console.log(errResponse);
		}
	} else {
		// 즉시 거래
		try {
			const res = await axios.post(
				`${process.env.END_POINT_PRODUCT}/trades/${category}/select/${id}/${size}`,
				{},
				{
					headers: {
						Authorization: `Bearer ${token}`,
					},
				},
			);
			if (res.status === 200) return true;
			else return false;
		} catch (e) {
			if (e.response !== undefined) {
				const errResponse = e.response.data;
				return errResponse.code;
			}
		}
	}
};
