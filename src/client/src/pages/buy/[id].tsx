import React, { FunctionComponent, useCallback } from "react";
import { useRouter } from "next/router";
import useSWR from "swr";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import TransactionTitle from "components/atoms/TransactionTitle";
import TransactionTemplate from "components/templates/TransactionTemplate";
import { ProductRes } from "types";
import { fetcher } from "lib/fetcher";
import axios from "axios";

import Swal from "sweetalert2";

const ProductBuy: FunctionComponent = () => {
	const router = useRouter();
	const { id, size, auction } = router.query;

	const { data: productInfo } = useSWR<ProductRes>(
		id ? `${process.env.END_POINT_PRODUCT}/products/${id}` : null,
		fetcher,
	);

	const onHandleTrade = useCallback(
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
					router.push({
						pathname: "/buy/complete",
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
					router.push({
						pathname: "/buy/complete",
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
			<TransactionTitle category={auction ? `ask` : `buy`} />
			{productInfo && (
				<TransactionTemplate
					category="buy"
					auction={auction === "true" ? true : false}
					imgSrc={productInfo.product.imageUrls[0]}
					backgroundColor={productInfo.product.backgroundColor}
					styledCode={productInfo.product.styleCode}
					originalName={productInfo.product.originalName}
					translatedName={productInfo.product.translatedName}
					selectedSize={size as string}
					askPricePerSize={productInfo.askPrices}
					bidPricePerSize={productInfo.bidPrices}
					instantPrice={productInfo.askPrices[size as string]}
					onHandleTrade={onHandleTrade}
				/>
			)}
		</NavTemplate>
	);
};

export default ProductBuy;
