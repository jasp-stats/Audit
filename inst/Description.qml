import QtQuick 			2.12
import JASP.Module 		1.0

Description
{
	name				: "jaspAudit"
	title				: qsTr("Audit")
	description			: qsTr("JASP for Audit (JfA) is an officially supported module that is designed specifically with the auditor in mind. JfA aids the auditor in interpreting, explaining, and reporting their sampling procedures and leaves a transparent audit trail.")
	version				: "0.3.1"
	author				: "Koen Derks, Jacques de Swart, Eric-Jan Wagenmakers, Jan Wille & Ruud Wetzels"
	maintainer			: "Koen Derks <k.derks@nyenrode.nl>"
	website				: "www.github.com/koenderks/jfa"
	license				: "GPL (>= 2)"
	icon				: "audit-module.svg"

	GroupTitle
	{
		title:			qsTr("Workflow")
		icon:			"audit-workflow.svg"
	}
	Analysis
	{
		menu:			qsTr("Sampling Workflow")
		title:			qsTr("Classical Sampling Workflow")
		func:			"auditClassicalWorkflow"
	}
	Analysis
	{
		title:			qsTr("Bayesian Sampling Workflow")
		func:			"auditBayesianWorkflow"
	}

	GroupTitle
	{
		title:			qsTr("Planning")
		icon:			"audit-planning.svg"
	}
	Analysis
	{
		menu:			qsTr("Planning")
		title:			qsTr("Classical Planning")
		func:			"auditClassicalPlanning"
		requiresData:	false
	}
	Analysis
	{
		title:			qsTr("Bayesian Planning")
		func:			"auditBayesianPlanning"
		requiresData:	false
	}

	GroupTitle
	{
		title:			qsTr("Selection")
		icon:			"audit-selection.svg"
	}
	Analysis
	{
		title:			qsTr("Selection")
		func:			"auditSelection"
	}

	GroupTitle
	{
		title:			qsTr("Evaluation")
		icon:			"audit-evaluation.svg"
	}
	Analysis
	{
		menu:			qsTr("Evaluation")
		title:			qsTr("Classical Evaluation")
		func:			"auditClassicalEvaluation"
		requiresData:	false
	}
	Analysis
	{
		title:			qsTr("Bayesian Evaluation")
		func:			"auditBayesianEvaluation"
		requiresData:	false
	}

	GroupTitle
	{
		title:			qsTr("Digit Analysis")
		icon:			"audit-number-analysis.svg"
	}
	Analysis
	{
		title:			qsTr("Benford's Law")
		func:			"auditClassicalBenfordsLaw"
	}
	Analysis
	{
		menu:			qsTr("Repeated Values")
		title:			qsTr("Repeated Values Analysis")
		func:			"auditClassicalNumberBunching"
	}

	GroupTitle
	{
		title:			qsTr("Other")
		icon:			"audit-other.svg"
	}
	Analysis
	{
		title:			qsTr("True Value Estimation")
		func:			"auditClassicalEstimation"
	}
}
