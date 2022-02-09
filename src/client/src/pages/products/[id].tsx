import React, { FunctionComponent, useEffect, useState } from "react";
import { useRouter } from "next/router";
import useSWR from "swr";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import ProductTemplate, {
	ProductTemplateLoading,
} from "components/templates/ProductTemplate";
import { fetcher } from "lib/fetcher";
import { ProductRes } from "types";
import { Oval } from "react-loader-spinner";

const Product: FunctionComponent = () => {
	const router = useRouter();
	const { id, size } = router.query;

	const [selectedSize, setSelectedSize] = useState<string>("");

	const { data: productInfo } = useSWR<ProductRes>(
		size
			? `${process.env.END_POINT_PRODUCT}/products/${id}/${size}`
			: `${process.env.END_POINT_PRODUCT}/products/${id}`,
		fetcher,
		{
			revalidateOnFocus: false,
			errorRetryCount: 3,
		},
	);

	useEffect(() => {
		console.log("productInfo가 바뀌었습니다######");
		if (
			productInfo &&
			!Object.keys(productInfo.askPrices).includes("ONE SIZE")
		) {
			setSelectedSize("모든 사이즈");
		} else if (productInfo) {
			setSelectedSize("ONE SIZE");
		}
		if (size) setSelectedSize(size as string);
	}, [productInfo]);

	if (!productInfo) {
		return (
			<NavTemplate
				headerTop={<HeaderTop />}
				headerMain={<HeaderMain />}
				footer={<Footer />}
			>
				<ProductTemplateLoading>
					<Oval
						ariaLabel="loading-indicator"
						height={100}
						width={100}
						strokeWidth={5}
						color="black"
						secondaryColor="white"
					/>
				</ProductTemplateLoading>
			</NavTemplate>
		);
	}

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			{productInfo && (
				<ProductTemplate
					activatedSize={selectedSize}
					setActivatedSize={setSelectedSize}
					productInfo={productInfo}
				/>
			)}
		</NavTemplate>
	);
};

export default Product;
