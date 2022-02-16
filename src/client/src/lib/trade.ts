import axios from "axios";

export const onHandleTrade = (
	async (category: string, auction: boolean, date: number, price: number) => {
		console.log(category, auction, date, price);
		if (auction) {
			// 경매 형식 && 구매
			try {
				const res = await axios.post(
					`${process.env.END_POINT_PRODUCT}/trades/products/${id}/${size}`,
					{
						price: price,
						requestType: "ASK",
						validationDay: date,
					},
					{
						headers: {
							userId: "1",
						},
					},
				);
				console.log(res);
			} catch (e) {
				console.error(e);
			}
		} else {
			// 즉시 구매
			try {
				const res = await axios.post(
					`${process.env.END_POINT_PRODUCT}/trades/buy/select/${id}/${size}`,
					{},
					{
						headers: {
							userId: "1",
						},
					},
				);
				console.log(res);
			} catch (e) {
				console.error(e);
			}
		}
	}
