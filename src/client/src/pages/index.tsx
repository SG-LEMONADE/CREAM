import React, { FunctionComponent } from "react";

import Home from "components/templates/Home";
import HeaderTop from "components/organisms/HeaderTop";

const home: FunctionComponent = () => {
	return (
		<Home header={<HeaderTop />}>
			<h1>Next JS 테스팅</h1>
		</Home>
	);
};

export default home;
