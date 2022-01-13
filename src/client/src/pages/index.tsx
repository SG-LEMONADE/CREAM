import React, { FunctionComponent } from "react";

import HomeTemplate from "components/templates/HomeTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";

const home: FunctionComponent = () => {
	return (
		<HomeTemplate headerTop={<HeaderTop />} headerMain={<HeaderMain />}>
			<h1>Next JS 테스팅</h1>
		</HomeTemplate>
	);
};

export default home;
