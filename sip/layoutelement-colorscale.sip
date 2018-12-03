/** PyQt5 binding for QCustomPlot v2
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPColorScale : public QCPLayoutElement
{
%TypeHeaderCode
#include <QCustomPlot/src/qcp.h>
%End
public:
  explicit QCPColorScale(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPColorScale();
  
  // getters:
  QCPAxis *axis() const;
  QCPAxis::AxisType type() const;
  QCPRange dataRange() const;
  QCPAxis::ScaleType dataScaleType() const;
  QCPColorGradient gradient() const;
  QString label() const;
  int barWidth () const;
  bool rangeDrag() const;
  bool rangeZoom() const;
  
  // setters:
  void setType(QCPAxis::AxisType type);
  Q_SLOT void setDataRange(const QCPRange &dataRange);
  Q_SLOT void setDataScaleType(QCPAxis::ScaleType scaleType);
  Q_SLOT void setGradient(const QCPColorGradient &gradient);
  void setLabel(const QString &str);
  void setBarWidth(int width);
  void setRangeDrag(bool enabled);
  void setRangeZoom(bool enabled);
  
  // non-property methods:
  QList<QCPColorMap*> colorMaps() const;
  void rescaleDataRange(bool onlyVisibleMaps);
  
  // reimplemented virtual methods:
  virtual void update(UpdatePhase phase);
  
signals:
  void dataRangeChanged(const QCPRange &newRange);
  void dataScaleTypeChanged(QCPAxis::ScaleType scaleType);
  void gradientChanged(const QCPColorGradient &newGradient);
};