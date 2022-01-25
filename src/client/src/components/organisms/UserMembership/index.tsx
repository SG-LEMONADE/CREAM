import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import UserDetail from "components/molecules/UserDetail";

type UserMemberShipProps = {
	imgSrc?: string;
	userName: string;
	userEmail: string;
};

const UserMemberShip: FunctionComponent<UserMemberShipProps> = (props) => {
	const { imgSrc, userName, userEmail } = props;

	return (
		<UserMemberShipWrapper>
			<UserDetailWrapper>
				<UserDetail imgSrc={imgSrc} userName={userName} userEmail={userEmail} />
			</UserDetailWrapper>
			<MemberShipDetailWrapper>
				<StyledA>
					<StyledStrong>일반 회원</StyledStrong>
					<StyledP>레몬 등급</StyledP>
				</StyledA>
			</MemberShipDetailWrapper>
		</UserMemberShipWrapper>
	);
};

export default UserMemberShip;

const UserMemberShipWrapper = styled.div`
	display: flex;
	padding: 23px 0 23px 23px;
	border: 1px solid #ebebeb;
	border-radius: 10px;
	background-color: #fff;
	justify-contents: space-between;
`;

const UserDetailWrapper = styled.div``;

const MemberShipDetailWrapper = styled.div`
	position: relative;
	margin-left: auto;
	display: flex;
	align-items: center;
	justify-content: center;
`;

const StyledA = styled.a`
	pointer-events: one;
	cursor: defualt;
	display: inline-block;
	width: 159px;
	text-align: center;
	text-decoration: none;
	&: before {
		content: "";
		position: absolute;
		top: 0;
		left: 10%;
		bottom: 0;
		background-color: #ebebeb;
		width: 1px;
	}
`;

const StyledStrong = styled.strong`
	display: block;
	line-height: 19px;
	font-size: 16px;
	letter-spacing: -0.16px;
	font-weight: 700;
`;

const StyledP = styled.p`
	line-height: 19px;
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.5);
`;
