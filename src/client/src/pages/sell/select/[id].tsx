import React, { FunctionComponent } from "react";
import { useRouter } from "next/router";
import useSWR from "swr";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import TransactionTitle from "components/atoms/TransactionTitle";
import { fetcherWithToken } from "lib/fetcher";
import { ProductRes } from "types";
import SizeSelectTemplate from "components/templates/SizeSelectTemplate";

const ProductBuySizeSelect: FunctionComponent = (props) => {
	const router = useRouter();
	const { id } = router.query;

	const { data: productInfo } = useSWR<ProductRes>(
		id ? `${process.env.END_POINT_PRODUCT}/products/${id}` : null,
		fetcherWithToken,
	);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<TransactionTitle category="sell" />
			{productInfo && (
				<SizeSelectTemplate
					category="sell"
					id={productInfo.product.id}
					imgSrc={productInfo.product.imageUrls[0]}
					backgroundColor={productInfo.product.backgroundColor}
					styledCode={productInfo.product.styleCode}
					originalName={productInfo.product.originalName}
					translatedName={productInfo.product.translatedName}
					sizes={productInfo.product.sizes}
					pricePerSize={productInfo.bidPrices}
				/>
			)}
		</NavTemplate>
	);
};

export default ProductBuySizeSelect;
