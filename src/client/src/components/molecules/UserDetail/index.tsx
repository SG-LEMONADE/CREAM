import React, { FunctionComponent, useCallback } from "react";
import Image from "next/image";

import Icon from "components/atoms/Icon";
import Button from "components/atoms/Button";

import styled from "@emotion/styled";
import Link from "next/link";

type UserDetailProps = {
	imgSrc?: string;
	userName: string;
	userEmail: string;
};

const UserDetail: FunctionComponent<UserDetailProps> = (props) => {
	const { imgSrc, userName, userEmail } = props;

	const trimEmail = useCallback(
		(email: string) => {
			const atIndex = email.indexOf("@");
			if (atIndex === -1) return;
			return `${email[0]}${"*".repeat(atIndex - 2)}${
				email[atIndex - 1]
			}${email.slice(atIndex)}`;
		},
		[userEmail],
	);

	return (
		<UserDetailWrapper>
			<UserThumb>
				{imgSrc ? (
					<StyleImg src={imgSrc} alt={imgSrc} />
				) : (
					<Icon
						name="Profile"
						style={{ width: "100px", height: "100px", color: "#d3d3d3" }}
					/>
				)}
			</UserThumb>
			<UserInfo>
				<InfoBox>
					<StyledName>{userName}</StyledName>
					<StyledEmail>{trimEmail(userEmail)}</StyledEmail>
					<Link href={"/my/profile"}>
						<a>
							<Button category="primary">프로필 수정</Button>
						</a>
					</Link>
				</InfoBox>
			</UserInfo>
		</UserDetailWrapper>
	);
};

export default UserDetail;

const UserDetailWrapper = styled.div`
	display: flex;
`;

const UserThumb = styled.div`
	position: relative;
	margin-right: 12px;
	width: 100px;
	height: 100px;
	border-radius: 100%;
	flex-shrink: 0;
`;

const StyleImg = styled(Image)`
	width: 100%;
	height: 100%;
	border-radius: 50%;
`;

const UserInfo = styled.div`
	display: flex;
	align-items: center;
`;

const InfoBox = styled.div`
	margin: 0;
	padding: 0;
`;

const StyledName = styled.strong`
	line-height: 21px;
	font-size: 18px;
	letter-spacing: -0.27px;
	font-weight: 600;
	color: #000;
`;

const StyledEmail = styled.p`
	line-height: 18px;
	font-size: 14px;
	letter-spacing: -0.05px;
	color: rgba(34, 34, 34, 0.5);
	margin: 0 0 10px 0;
`;
