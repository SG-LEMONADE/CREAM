import React, { FunctionComponent, useCallback, useState } from "react";
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
import { GetProductWishRes } from "types";

import Swal from "sweetalert2";
import Pagination from "rc-pagination";
import "rc-pagination/assets/index.css";

const MyTradeBuying: FunctionComponent = () => {
	const [cursor, setCursor] = useState<number>(0);

	const { data: wishProducts, mutate } = useSWR<GetProductWishRes>(
		`${process.env.END_POINT_PRODUCT}/products/wishes?cursor=${cursor}&perPage=10`,
		fetcher,
	);

	const onHandleChange = useCallback(
		(current: number, pageSize: number) => {
			setCursor(current - 1);
		},
		[setCursor],
	);

	/** For Code Review
	 * 찜 제거를 위해 post 요청 수행.
	 * 요청을 마치고 성공했다면 mutate를 통해 갱신된 정보를 다시 불러 찜 목록을 업데이트 해줍니다.
	 * 삭제를 누른 찜 상품이 제거된 것을 본 유저는 정상적으로 삭제되었음을 확인합니다.
	 */
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
				/** For Code Review
				 * 아래 mutate를 통해 갱신합니다.
				 */
				mutate();
				Swal.fire({
					position: "top",
					icon: "success",
					html: `삭제되었습니다.`,
					showConfirmButton: false,
					timer: 2000,
				});
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
					wishProducts.products.map((product) => (
						<ProductWish
							key={`${product.id}/${product.size}`}
							id={product.id}
							lowestAsk={product.lowestAsk}
							imgSrc={product.imageUrls[0]}
							backgroundColor={product.backgroundColor}
							productName={product.originalName}
							size={product.size}
							onDeleteWish={() => onDeleteWish(product.id, product.size)}
						/>
					))}
				{wishProducts && (
					<Pagination
						defaultPageSize={10}
						total={wishProducts.count}
						current={cursor + 1}
						onChange={onHandleChange}
						style={{ textAlign: "center", marginTop: "40px" }}
					/>
				)}
			</MyPageTemplate>
		</NavTemplate>
	);
};

export default MyTradeBuying;
