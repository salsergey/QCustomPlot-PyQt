%Copying
PyQt5 binding for QCustomPlot v2.1.0

Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert, Sergey Salnikov
License: MIT

QCustomPlot author: Emanuel Eichhammer
QCustomPlot Website/Contact: http://www.qcustomplot.com
%End

%Module QCustomPlot2


%Import QtCore/QtCoremod.sip
%Import QtGui/QtGuimod.sip
%Import QtWidgets/QtWidgetsmod.sip

// Include order taken from qcp.h
%Include global.sip
%Include vector2d.sip
%Include painter.sip
// #include "paintbuffer.h"
%Include layer.sip
%Include range.sip
%Include selection.sip
%Include selectionrect.sip
%Include layout.sip
%Include lineending.sip
%Include axisticker.sip
%Include axistickerdatetime.sip
%Include axistickertime.sip
%Include axistickerfixed.sip
%Include axistickertext.sip
%Include axistickerpi.sip
%Include axistickerlog.sip
%Include axis.sip
%Include scatterstyle.sip
%Include datacontainer.sip
%Include plottable.sip
%Include item.sip
%Include core.sip
%Include plottable1d.sip
%Include colorgradient.sip
%Include selectiondecorator-bracket.sip
%Include layoutelement-axisrect.sip
%Include layoutelement-legend.sip
%Include layoutelement-textelement.sip
%Include layoutelement-colorscale.sip
%Include plottable-graph.sip
%Include plottable-curve.sip
%Include plottable-bars.sip
%Include plottable-statisticalbox.sip
%Include plottable-colormap.sip
%Include plottable-financial.sip
%Include plottable-errorbar.sip
%Include item-straightline.sip
%Include item-line.sip
%Include item-curve.sip
%Include item-rect.sip
%Include item-text.sip
%Include item-ellipse.sip
%Include item-pixmap.sip
%Include item-tracer.sip
%Include item-bracket.sip
%Include radialaxis.sip
%Include layoutelement-angularaxis.sip
%Include polargrid.sip
%Include polargraph.sip
