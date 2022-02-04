import React, { FunctionComponent } from "react";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import JoinForm from "components/organisms/JoinForm";
import NavTemplate from "components/templates/NavTemplate";

const Join: FunctionComponent = () => {
	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<JoinForm />
		</NavTemplate>
	);
};

export default Join;
