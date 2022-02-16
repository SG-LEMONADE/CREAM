import { useRouter } from "next/router";
import React, { FunctionComponent, useEffect } from "react";
import useSWR from "swr";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import CompleteTemplate from "components/templates/CompleteTemplate";
import { ProductRes } from "types";
import { fetcher } from "lib/fetcher";

const BuyComplete: FunctionComponent = () => {
	const router = useRouter();
	const { id, auction, price, date } = router.query;

	const { data: productInfo } = useSWR<ProductRes>(
		id ? `${process.env.END_POINT_PRODUCT}/products/${id}` : null,
		fetcher,
	);

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			{productInfo && (
				<CompleteTemplate
					category="buy"
					auction={auction === "true" ? true : false}
					imageUrl={productInfo.product.imageUrls[0]}
					backgroundColor={productInfo.product.backgroundColor}
					price={parseInt(price as string)}
					date={parseInt(date as string)}
				/>
			)}
		</NavTemplate>
	);
};

export default BuyComplete;
