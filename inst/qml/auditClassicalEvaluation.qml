//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//

// When making changes to this file always mention @koenderks as a
// reviewer in the Pull Request

import QtQuick			2.8
import QtQuick.Layouts	1.3
import JASP.Controls	1.0
import JASP.Widgets		1.0

Form
{
	usesJaspResults: 	true
	columns: 			1

	// Extra options
	RadioButtonGroup {
		name: "IR"
		visible: false
		RadioButton { name: "High"; checked: true}
	}

	RadioButtonGroup {
		name: "CR"
		visible: false
		RadioButton { name: "High"; checked: true}
	}

		GridLayout
	{
		columns: 3

		RadioButtonGroup
		{
			id: 		materiality
			name: 	"materiality"
			title: 	qsTr("Population Materiality")

			RowLayout
			{
				RadioButton
				{
					id: 								materialityAbsolute
					name: 							"materialityAbsolute"
					text: 							qsTr("Absolute")
					checked: 						true
					childrenOnSameRow: 	true

					DoubleField
					{
						id: 							materialityValue
						visible: 					materialityAbsolute.checked
						name: 						"materialityValue"
						defaultValue: 		0
						min: 							0
						fieldWidth: 			90
						decimals: 				2
						label: 						euroValuta.checked ? "€" : (dollarValuta.checked ? "$" : otherValutaName.value)
					}
				}
			}

			RowLayout
			{
				RadioButton
				{
					id: 								materialityRelative
					name: 							"materialityRelative"
					text: 							qsTr("Relative")
					childrenOnSameRow: 	true

					PercentField
					{
						id: 							materialityPercentage
						visible: 					materialityRelative.checked
						decimals: 				2
						defaultValue: 		0
						name: 						"materialityPercentage"
						fieldWidth: 			40
					}
				}
			}
		}

		GroupBox
		{
			title: qsTr("Population")

			IntegerField
			{
				id: 			populationSize
				name: 			"populationSize"
				text: 			qsTr("Size")
				fieldWidth: 	100
				defaultValue: 	0
				min: 			0
			}

			DoubleField
			{
				id: 			populationValue
				name: 			"populationValue"
				text: 			qsTr("Value")
				defaultValue: 	0
				fieldWidth: 	100
				min: 			0
				decimals: 		2
			}
		}

		GroupBox
		{
			id: 		auditRisk
			title: 		qsTr("Audit Risk")

			PercentField
			{
				name: 			"confidence"
				label: 			qsTr("Confidence")
				decimals: 		2
				defaultValue: 	95
			}
		}
	}

	Divider { width: parent.width }

	VariablesForm
	{
		preferredHeight: jaspTheme.smallDefaultVariablesFormHeight
		enabled:					!useSummaryStatistics.checked

		AvailableVariablesList
		{
			name: 	"evaluationVariables"
		}

		AssignedVariablesList
		{
			id: 				recordNumberVariable
			name: 				"recordNumberVariable"
			title: 				qsTr("Record ID's")
			singleVariable: 	true
			allowedColumns: 	["ordinal", "scale"]
		}

		AssignedVariablesList
		{
			id: 			auditResult
			name: 			"auditResult"
			title: 			qsTr("Audit Result")
			singleVariable: true
			allowedColumns: ["nominal" ,"scale"]
		}

		AssignedVariablesList
		{
			id: 				monetaryVariable
			name: 				"monetaryVariable"
			title: 				variableTypeAuditValues.checked ? qsTr("Book Values <i>(required)</i>") : qsTr("Book Values <i>(optional)</i>")
			singleVariable: 	true
			allowedColumns: 	["scale"]
		}

		AssignedVariablesList
		{
			id: 				sampleCounter
			name: 				"sampleCounter"
			title: 				qsTr("Selection Counter <i>(optional)</i>")
			singleVariable: 	true
			allowedColumns: 	["nominal"]
		}
	}

	RadioButtonGroup {
		id:						variableType 
		title: 				qsTr("Annotation method")
		name:					"variableType"

		RadioButton {
			id: 				variableTypeAuditValues
			name:				"variableTypeAuditValues"
			label: 			qsTr("Audit values")
			checked:		true
		}

		RadioButton {
			id: 				variableTypeCorrect
			name:				"variableTypeCorrect"
			label: 			qsTr("Correct / Incorrect")	
			enabled:		materialityRelative.checked

			CheckBox {
				id: 			useSummaryStatistics
				name: 		"useSumStats"
				label:		qsTr("Use summary statistics")

				IntegerField
				{
					id: 						nSumStats
					name: 					"nSumStats"
					text: 					qsTr("Sample size")
					defaultValue: 	0
					min: 						0
					visible:				useSummaryStatistics.checked
				}

				IntegerField
				{
					id: 						kSumStats
					name: 					"kSumStats"
					text: 					qsTr("Found errors")
					defaultValue: 	0
					min: 						0
					visible:				useSummaryStatistics.checked
					max:						nSumStats.value
				}
			}
		}
	}

	Section
	{
		title: 		qsTr("Advanced Options");
		columns: 	1

		GridLayout
		{
			columns: 2

			RadioButtonGroup
			{
				title: 	qsTr("Estimation Method")
				name: 	"estimator"

				RadioButton
				{
					id: 		stringerBound
					name: 		"stringerBound"
					text: 		qsTr("Stringer")
					enabled: 	variableTypeAuditValues.checked
					checked: 	true

					CheckBox
					{
						id: 		stringerBoundLtaAdjustment
						name: 		"stringerBoundLtaAdjustment"
						text: 		qsTr("LTA adjustment")
						enabled:	variableTypeAuditValues.checked
						checked: 	true
					}
				}

				RadioButton 
				{ 
					name: "directBound"		
					text: qsTr("Direct") 			
					id: directBound		
					enabled: !variableTypeCorrect.checked
				}
				
				RadioButton 
				{ 
					name: "differenceBound"
					text: qsTr("Difference")
					id: differenceBound
					enabled: !variableTypeCorrect.checked
				}

				RadioButton 
				{ 
					name: "ratioBound"
					text: qsTr("Ratio")
					id: ratioBound
					enabled: !variableTypeCorrect.checked 
				}

				RadioButton 
				{ 
					name: "regressionBound"
					text: qsTr("Regression")
					id: regressionBound
					enabled: !variableTypeCorrect.checked
				}
				
				RadioButton 
				{ 
					name: "binomialBound"
					text: qsTr("Binomial")
					id: binomialBound
					enabled: variableTypeCorrect.checked
				}
				
				RadioButton 
				{ 
					name: "poissonBound"
					text: qsTr("Poisson")
					id: poissonBound
					enabled: variableTypeCorrect.checked
				}
				
				RadioButton 
				{ 
					name: "hyperBound"
					text: qsTr("Hypergeometric")
					id: hyperBound
					enabled: variableTypeCorrect.checked 
				}
			}

			GroupBox
			{
				title: qsTr("Explanatory Text")

				RowLayout
				{
					CheckBox
					{
						id: 		explanatoryText
						text:	 	qsTr("Enable")
						name: 		"explanatoryText"
						checked: 	true
					}

					HelpButton
					{
						helpPage:			"Audit/explanatoryText"
						toolTip: 			qsTr("Show explanatory text and formulas")
					}
				}
			}
		}
	}

	Section
	{
		title: qsTr("Tables and Plots")

		GridLayout
		{
			columns: 2

			ColumnLayout {

				GroupBox
				{
					title: qsTr("Statistics")

					CheckBox
					{
						text: 		qsTr("Most likely error (MLE)")
						name: 		"mostLikelyError"
						checked: 	false
					}
				}
			}

			GroupBox
			{
				title: qsTr("Plots")

				CheckBox 
				{ 
					text: qsTr("Evaluation information")
					name: "evaluationInformation" 												
				}

				CheckBox 
				{ 
					text: qsTr("Correlation plot")
					name: "correlationPlot"
					enabled: variableTypeAuditValues.checked 	
				}
			}
		}
	}

	Item
	{
		Layout.preferredHeight: toInterpretation.height
		Layout.fillWidth: 			true

		Button
		{
			id: 			toInterpretation
			anchors.right:	parent.right
			text:			qsTr("<b>Download Report</b>")
			enabled: 		auditResult.count > 0
			onClicked:
			{
				evaluationPhase.expanded = false
				form.exportResults()
			}
		}
	}
}
