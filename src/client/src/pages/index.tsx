import React, { FunctionComponent } from "react";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import HomeTemplate from "components/templates/HomeTemplate";

const Home: FunctionComponent = () => {
	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<HomeTemplate children={<h1>Test</h1>} />
		</NavTemplate>
	);
};

export default Home;
