import "@emotion/react";

declare module "@emotion/react" {
	export interface Color {
		colors: {
			default: string;
			error: string;
			plain: string;
			tag: string;
			border: string;
		};
		buttonTextColors: {
			primary: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
			buy: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
			sell: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
		};
		buttonBgColors: {
			primary: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
			buy: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
			sell: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
		};
		borderColors: {
			primary: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
			buy: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
			sell: {
				default: string;
				active: string;
				hover: string;
				disabled: string;
			};
		};
	}
}
