import React, { FunctionComponent } from "react";
import useSWR from "swr";

import Footer from "components/organisms/Footer";
import HeaderMain from "components/organisms/HeaderMain";
import HeaderTop from "components/organisms/HeaderTop";
import HomeTemplate from "components/templates/HomeTemplate";
import ShopTemplate from "components/templates/ShopTemplate";
import { fetcher } from "lib/fetcher";
import ProductThumbnail from "components/organisms/ProductThumbnail";

const Search: FunctionComponent = () => {
	const { data, error } = useSWR(
		//`${process.env.END_POINT_PRODUCT}/filters`,
		"http://ec2-3-35-137-187.ap-northeast-2.compute.amazonaws.com:8081/products?cursor=0&perPage=40",
		fetcher,
	);

	return (
		<HomeTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<ShopTemplate>
				{data &&
					data.map((obj) => (
						<ProductThumbnail
							category="shop"
							productInfo={obj}
							isWishState={true}
							onHandleWishClick={() => console.log("!")}
						/>
					))}
			</ShopTemplate>
		</HomeTemplate>
	);
};

export default Search;
