import React, { FunctionComponent } from "react";
import { useRouter } from "next/router";
import useSWR from "swr";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import TransactionTitle from "components/atoms/TransactionTitle";
import { fetcher } from "lib/fetcher";
import { ProductRes } from "types";
import SizeSelectTemplate from "components/templates/SizeSelectTemplate";

const ProductBuySizeSelect: FunctionComponent = (props) => {
	const router = useRouter();
	const { id } = router.query;

	const { data: productInfo } = useSWR<ProductRes>(
		id ? `${process.env.END_POINT_PRODUCT}/products/${id}` : null,
		fetcher,
	);

	/**
	 * 사용자가 선택한 제품이 지원하는 사이즈 배열을 기반으로 SizeSelectTemplate -> ProductSizeSelectGrid로
	 * props를 전달하여 그리드 화면을 작성합니다.
	 */
	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<TransactionTitle category="buy" />
			{productInfo && (
				<SizeSelectTemplate
					category="buy"
					id={productInfo.product.id}
					imgSrc={productInfo.product.imageUrls[0]}
					backgroundColor={productInfo.product.backgroundColor}
					styledCode={productInfo.product.styleCode}
					originalName={productInfo.product.originalName}
					translatedName={productInfo.product.translatedName}
					sizes={productInfo.product.sizes}
					pricePerSize={productInfo.askPrices}
				/>
			)}
		</NavTemplate>
	);
};

export default ProductBuySizeSelect;
