import React, { FunctionComponent, useCallback } from "react";
import Image from "next/image";

import Icon from "components/atoms/Icon";
import Button from "components/atoms/Button";

import styled from "@emotion/styled";
import Link from "next/link";

type UserDetailProps = {
	category: "get" | "put";
	imgSrc?: string;
	userName: string;
	userEmail?: string;
	onChangeImage?: () => void;
	onRemoveImage?: () => void;
};

const UserDetail: FunctionComponent<UserDetailProps> = (props) => {
	const {
		category,
		imgSrc,
		userName,
		userEmail,
		onChangeImage,
		onRemoveImage,
	} = props;

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
		<UserDetailWrapper category={category}>
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
					{category === "get" && (
						<StyledName activated={userName !== null}>
							{userName !== null ? userName : "닉네임을 설정해주세요."}
						</StyledName>
					)}
					{category === "put" && (
						<StyledNamePut activated={userName !== null}>
							{userName !== null ? userName : "닉네임을 설정해주세요."}
						</StyledNamePut>
					)}
					{category === "get" && (
						<StyledEmail>{trimEmail(userEmail)}</StyledEmail>
					)}
					{category === "get" && (
						<Link href={"/my/profile"}>
							<a>
								<Button category="primary">프로필 수정</Button>
							</a>
						</Link>
					)}
					{category === "put" && (
						<ButtonWrapper>
							<Button onClick={onChangeImage} category="primary">
								이미지 변경
							</Button>
							<Button
								onClick={onRemoveImage}
								style={{ marginLeft: "10px" }}
								category="primary"
							>
								삭제
							</Button>
						</ButtonWrapper>
					)}
				</InfoBox>
			</UserInfo>
		</UserDetailWrapper>
	);
};

export default UserDetail;

const UserDetailWrapper = styled.div<{ category: string }>`
	display: flex;
	padding: ${({ category }) => category === "put" && "50px 0 38px"};
	border-bottom: ${({ category }) => category === "put" && "1px solid #d3d3d3"};
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

const StyledName = styled.strong<{ activated: boolean }>`
	line-height: 21px;
	font-size: 18px;
	letter-spacing: -0.27px;
	font-weight: 600;
	color: ${({ activated }) => (activated ? `#000` : `rgba(34, 34, 34, 0.5)`)};
`;

const StyledNamePut = styled.strong<{ activated: boolean }>`
	font-size: 20px;
	line-height: 32px;
	letter-spacing: -0.12px;
	color: ${({ activated }) => (activated ? `#000` : `rgba(34, 34, 34, 0.5)`)};
`;

const ButtonWrapper = styled.div`
	display: flex;
	margin-top: 10px;
`;

const StyledEmail = styled.p`
	line-height: 18px;
	font-size: 14px;
	letter-spacing: -0.05px;
	color: rgba(34, 34, 34, 0.5);
	margin: 0 0 10px 0;
`;
