import { AppProps } from "next/app";

import UserProvider from "provider/UserProvider";

import "styles/global.css";

export default function App({
	Component,
	pageProps,
}: AppProps): React.ReactNode {
	return (
		<UserProvider>
			<Component {...pageProps} />
		</UserProvider>
	);
}
