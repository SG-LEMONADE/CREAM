import React, { FunctionComponent } from "react";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";

const Home: FunctionComponent = () => {
	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<h1>Testing</h1>
			<h1>Testing</h1>
			<h1>Testing</h1>
		</NavTemplate>
	);
};

export default Home;
