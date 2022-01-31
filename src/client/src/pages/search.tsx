import React, { FunctionComponent } from "react";

import Footer from "components/organisms/Footer";
import HeaderMain from "components/organisms/HeaderMain";
import HeaderTop from "components/organisms/HeaderTop";
import HomeTemplate from "components/templates/HomeTemplate";
import ShopTemplate from "components/templates/ShopTemplate";

const Search: FunctionComponent = () => {
	return (
		<HomeTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<ShopTemplate>
				<h2>Test</h2>
			</ShopTemplate>
		</HomeTemplate>
	);
};

export default Search;
