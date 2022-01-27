import React, { FunctionComponent } from "react";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import JoinForm from "components/organisms/JoinForm";
import HomeTemplate from "components/templates/HomeTemplate";

const Join: FunctionComponent = () => {
	return (
		<HomeTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<JoinForm />
		</HomeTemplate>
	);
};

export default Join;
