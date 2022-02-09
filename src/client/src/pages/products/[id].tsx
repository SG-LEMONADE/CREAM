import React, { FunctionComponent, useEffect, useState } from "react";
import { useRouter } from "next/router";
import useSWR from "swr";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import ProductTemplate from "components/templates/ProductTemplate";
import { fetcher } from "lib/fetcher";
import { ProductRes } from "types";

const Product = () => {
	const router = useRouter();
	const { id } = router.query;

	const [selectedSize, setSelectedSize] = useState<string>("");

	const {
		data: productInfo,
		error,
		mutate,
	} = useSWR<ProductRes>(
		`${process.env.END_POINT_PRODUCT}/products/${id}`,
		fetcher,
		{
			revalidateOnFocus: false,
			errorRetryCount: 3,
		},
	);

	useEffect(() => {
		if (productInfo) {
			setSelectedSize(productInfo.product.sizes[0]);
		}
	}, [productInfo]);

	if (!productInfo) {
		return (
			<NavTemplate
				headerTop={<HeaderTop />}
				headerMain={<HeaderMain />}
				footer={<Footer />}
			>
				<h1>Loading</h1>
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
