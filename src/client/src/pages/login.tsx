import React, { FunctionComponent } from "react";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import LoginForm from "components/organisms/LoginForm";
import HomeTemplate from "components/templates/HomeTemplate";

const Login: FunctionComponent = () => {
	return (
		<HomeTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<LoginForm />
		</HomeTemplate>
	);
};

export default Login;
