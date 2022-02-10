import React, { FunctionComponent, useCallback } from "react";
import useSWR from "swr";
import axios from "axios";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import NavTemplate from "components/templates/NavTemplate";
import MyPageTemplate from "components/templates/MyPageTemplate";
import ProductWish, {
	StyledTitle,
	StyledH3,
} from "components/organisms/ProductWish";
import { fetcher } from "lib/fetcher";
import { ProductInfoRes } from "types";

const MyTradeBuying: FunctionComponent = () => {
	const { data: wishProducts, mutate } = useSWR<ProductInfoRes[]>(
		`${process.env.END_POINT_PRODUCT}/products/wishes?cursor=0&perPage=10`,
		fetcher,
	);

	const onDeleteWish = useCallback(async (id: number, size: string) => {
		try {
			const res = await axios.post(
				`${process.env.END_POINT_PRODUCT}/wish/${id}/${size}`,
				{},
				{
					headers: {
						userId: "1",
					},
				},
			);
			const data = res.data;
			if (data !== "") {
				console.error(
					`Something wrong when posting. error code ${res.status}}`,
				);
			} else {
				mutate();
			}
		} catch (e) {
			console.error(e);
			// errResponse.code && alert(`${process.env.ERROR_code[parseInt(errResponse.code)]}`);
		}
	}, []);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<MyPageTemplate>
				<StyledTitle>
					<StyledH3>관심 상품</StyledH3>
				</StyledTitle>
				{wishProducts &&
					wishProducts.map((product) => (
						<ProductWish
							key={product.id}
							id={product.id}
							lowestAsk={product.lowestAsk}
							imgSrc={product.imageUrls[0]}
							backgroundColor={product.backgroundColor}
							productName={product.originalName}
							// FIX ME
							size={product.wishList !== null && product.wishList[0]}
							onDeleteWish={() => onDeleteWish(product.id, product.wishList[0])}
						/>
					))}
			</MyPageTemplate>
		</NavTemplate>
	);
};

export default MyTradeBuying;
