import React, { FunctionComponent } from "react";
import Link from "next/link";

import Logo from "components/atoms/Logo";
import HeaderMainItem from "components/atoms/HeaderMainItem";
import Icon from "components/atoms/Icon";

import colors from "colors/color";
import styled from "@emotion/styled";

const HeaderMain: FunctionComponent = () => {
	return (
		<HeaderMainWrapper>
			<Link href={"/"}>
				<a>
					<Logo category={"Logo"} />
				</a>
			</Link>
			<StyledGNBArea>
				<HeaderMainItem
					onClick={() => alert("Coming soon...")}
					children="STYLE"
				/>
				<Link href={"/search"}>
					<a>
						<HeaderMainItem children="SHOP" />
					</a>
				</Link>
				<Link href={"https://github.com/SG-LEMONADE/CREAM"}>
					<a>
						<HeaderMainItem children="ABOUT" />
					</a>
				</Link>
				<Icon name="Magnifier" style={{ cursor: "pointer" }} />
			</StyledGNBArea>
		</HeaderMainWrapper>
	);
};

export default HeaderMain;

const HeaderMainWrapper = styled.header`
	display: flex;
	padding: 0 40px 0 5px;
	height: 68px;
	min-width: 320px;
	align-items: center;
	border-bottom: 1px solid ${colors.colors.border};
	svg:first-child {
		padding-top: 15px;
	}
	first-of-type {
		padding-top: 15px;
	}
`;

const StyledGNBArea = styled.header`
	display: flex;
	align-items: center;
	margin-left: auto;
	li {
		margin-right: 40px;
	}
	@media screen and (max-width: 770px) {
		> li {
			display: none;
		}
	}
`;
