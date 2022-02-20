import { AppProps } from "next/app";
import Head from "next/head";

import UserProvider from "provider/UserProvider";

import "styles/global.css";

export default function App({
	Component,
	pageProps,
}: AppProps): React.ReactNode {
	return (
		<>
			<Head>
				<title>CREAM</title>
				<meta
					name="description"
					content="Collapse Rules Everything Around Me"
				/>
				{process.env.DEPLOY_VER && (
					<meta
						httpEquiv="Content-Security-Policy"
						content="upgrade-insecure-requests"
					/>
				)}
				<link rel="icon" href="/favicon.ico" />
			</Head>
			<UserProvider>
				<Component {...pageProps} />
			</UserProvider>
		</>
	);
}
