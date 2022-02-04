import React, { FunctionComponent } from "react";

import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import LoginForm from "components/organisms/LoginForm";
import NavTemplate from "components/templates/NavTemplate";

const Login: FunctionComponent = () => {
	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<LoginForm />
		</NavTemplate>
	);
};

export default Login;
