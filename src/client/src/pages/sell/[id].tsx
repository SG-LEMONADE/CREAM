import React, { FunctionComponent, useCallback } from "react";
import { useRouter } from "next/router";
import useSWR from "swr";
import axios from "axios";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import TransactionTitle from "components/atoms/TransactionTitle";
import TransactionTemplate from "components/templates/TransactionTemplate";
import { ProductRes } from "types";
import { fetcherWithToken } from "lib/fetcher";

import Swal from "sweetalert2";
import { getToken } from "lib/token";

const ProductSell: FunctionComponent = () => {
	const router = useRouter();
	const { id, size, auction } = router.query;

	const { data: productInfo } = useSWR<ProductRes>(
		id ? `${process.env.END_POINT_PRODUCT}/products/${id}` : null,
		fetcherWithToken,
	);

	const onHandleTrade = useCallback(
		async (category: string, auction: boolean, date: number, price: number) => {
			const token = getToken("accessToken");
			console.log(category, auction, date, price);
			if (auction) {
				// 경매 형식 && 판매
				try {
					const res = await axios.post(
						`${process.env.END_POINT_PRODUCT}/trades/products/${id}/${size}`,
						{
							price: price,
							requestType: "BID",
							validationDay: date,
						},
						{
							headers: {
								Authorization: `Bearer ${token}`,
							},
						},
					);
					router.push({
						pathname: "/sell/complete",
						query: {
							id: id,
							auction: auction,
							price: price,
							date: date,
						},
					});
				} catch (e) {
					const errResponse = e.response.data;
					errResponse.code &&
						Swal.fire({
							position: "top",
							icon: "error",
							html: `${process.env.ERROR_code[parseInt(errResponse.code)]}`,
							showConfirmButton: false,
							timer: 2000,
						});
				}
			} else {
				// 즉시 판매
				try {
					const res = await axios.post(
						`${process.env.END_POINT_PRODUCT}/trades/sell/select/${id}/${size}`,
						{},
						{
							headers: {
								Authorization: `Bearer ${token}`,
							},
						},
					);
					router.push({
						pathname: "/sell/complete",
						query: {
							id: id,
							auction: auction,
							price: price,
							date: date,
						},
					});
				} catch (e) {
					const errResponse = e.response.data;
					console.log(errResponse);
					errResponse.code &&
						Swal.fire({
							position: "top",
							icon: "error",
							html: `${process.env.ERROR_code[parseInt(errResponse.code)]}`,
							showConfirmButton: false,
							timer: 2000,
						});
				}
			}
		},
		[],
	);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<TransactionTitle category="sell" />
			{productInfo && (
				<TransactionTemplate
					category="sell"
					auction={auction === "true" ? true : false}
					imgSrc={productInfo.product.imageUrls[0]}
					backgroundColor={productInfo.product.backgroundColor}
					styledCode={productInfo.product.styleCode}
					originalName={productInfo.product.originalName}
					translatedName={productInfo.product.translatedName}
					selectedSize={size as string}
					askPricePerSize={productInfo.askPrices}
					bidPricePerSize={productInfo.bidPrices}
					instantPrice={productInfo.bidPrices[size as string]}
					onHandleTrade={onHandleTrade}
				/>
			)}
		</NavTemplate>
	);
};

export default ProductSell;
