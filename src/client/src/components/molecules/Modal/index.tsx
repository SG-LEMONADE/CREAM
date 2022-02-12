import React, { FunctionComponent, useState, useEffect } from "react";
import ReactDOM from "react-dom";

import styled from "@emotion/styled";
import { css, keyframes } from "@emotion/react";
import Icon from "components/atoms/Icon";
import Button from "components/atoms/Button";

type ModalProps = {
	category: "wish" | "else" | "search";
	show: boolean;
	onClose: () => void;
	children: React.ReactNode;
	title?: string;
};

const Modal: FunctionComponent<ModalProps> = (props) => {
	const { category, show, onClose, children, title } = props;

	const [isBrowser, setIsBrowser] = useState(false);

	const onHandleCloseClick = (
		e: React.MouseEvent<SVGSVGElement, MouseEvent>,
	) => {
		e.preventDefault();
		onClose();
	};

	useEffect(() => {
		setIsBrowser(true);
	}, []);

	const modalContent = show ? (
		<StyledModalOverlay onClick={onClose} category={category}>
			<StyledModal category={category} onClick={(e) => e.stopPropagation()}>
				<StyledModalHeader>
					{title && <StyledModalTitle>{title}</StyledModalTitle>}
					{title && (
						<Icon
							name="Close"
							style={{
								position: "absolute",
								width: "24px",
								height: "24px",
								cursor: "pointer",
							}}
							onClick={onHandleCloseClick}
						/>
					)}
				</StyledModalHeader>
				<StyledModalBody category={category}>{children}</StyledModalBody>
				{category === "wish" && (
					<ModalButtonArea>
						<Button onClick={onClose} category="primary">
							확인
						</Button>
					</ModalButtonArea>
				)}
			</StyledModal>
		</StyledModalOverlay>
	) : null;

	if (isBrowser) {
		return ReactDOM.createPortal(
			modalContent,
			document.getElementById("modal-root"),
		);
	} else {
		return null;
	}
};

const StyledModalOverlay = styled.div<{ category: string }>`
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: ${({ category }) =>
		category === "search" ? `flex-start` : `center`};
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 100;
`;

const appearBelow = keyframes`
  from {
	opacity: 0;
	transform: translateY(20px);
  }
  to {
	opacity: 1;
	transform: translateY(0);
  }
`;

const appearAbove = keyframes`
  from {
	opacity: 0;
	transform: translateY(-80px);
  }
  to {
	opacity: 1;
	transform: translateY(0);
  }
`;

const StyledModal = styled.div<{ category: string }>`
	background: white;
	width: ${({ category }) => (category === "wish" ? "440px" : "480px")};
	max-height: ${({ category }) => (category === "wish" ? "527px" : "514px")};
	border-radius: 16px;
	padding: 15px;
	overflow: auto;
	display: flex;
	flex-direction: column;
	animation: ${appearBelow} 0.8s cubic-bezier(0.77, 0, 0.175, 1) forwards;
	z-index: 99;
	${({ category }) =>
		category === "search" &&
		css`
			width: 40%;
			animation: ${appearAbove} 1s cubic-bezier(0.77, 0, 0.175, 1) forwards;
			border-radius: 0 0 16px 16px;
		`}
`;

const StyledModalHeader = styled.div`
	display: flex;
	justify-content: flex-end;
	line-height: 22px;
`;

const StyledModalTitle = styled.h2`
	margin: 0 auto;
	font-weight: 700;
	text-align: center;
	font-size: 18px;
	min-height: 30px;
	padding: 5px 50px 20px;
	letter-spacing: -0.15px;
	color: #000;
	background-color: #fff;
`;

const StyledModalBody = styled.div<{ category: string }>`
	flex: 1;
	margin-top: 10px;
	margin-bottom: ${({ category }) => (category === "wish" ? "10px" : "32px")};
	overflow-x: hidden;
	overflow-y: auto;
	${({ category }) =>
		category === "search" &&
		css`
			margin: 0 auto;
			padding-bottom: 20px;
		`}
`;

const ModalButtonArea = styled.div`
	padding: 6px 8px 8px;
	display: flex;
	justify-content: center;
`;

export default Modal;
