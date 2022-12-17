/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPStatisticalBoxData
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  QCPStatisticalBoxData();
  QCPStatisticalBoxData(double key, double minimum, double lowerQuartile, double median, double upperQuartile, double maximum, const QVector<double>& outliers=QVector<double>());
  
  double sortKey() const;
  static QCPStatisticalBoxData fromSortKey(double sortKey);
  static bool sortKeyIsMainKey();
  
  double mainKey() const;
  double mainValue() const;
  
  QCPRange valueRange() const;
  
  double key;
  double minimum;
  double lowerQuartile;
  double median;
  double upperQuartile;
  double maximum;
  QVector<double> outliers;
};

typedef QCPAbstractPlottable1D<QCPStatisticalBoxData> QCPAbstractPlottable1D_QCPStatisticalBoxData;
typedef QCPDataContainer<QCPStatisticalBoxData> QCPStatisticalBoxDataContainer;
typedef QCPDataContainerIterator<QCPStatisticalBoxData> QCPStatisticalBoxDataContainerIterator;

class QCPStatisticalBox : public QCPAbstractPlottable1D_QCPStatisticalBoxData
{
%TypeHeaderCode
#include <qcustomplot.h>

typedef QCPAbstractPlottable1D<QCPStatisticalBoxData> QCPAbstractPlottable1D_QCPStatisticalBoxData;
%End
public:
  explicit QCPStatisticalBox(QCPAxis *keyAxis, QCPAxis *valueAxis) /Transfer/;
  
  // getters:
  QCPStatisticalBoxDataContainer* data() const;
  %MethodCode
    sipRes = sipCpp->data().data();
  %End
  double width() const;
  double whiskerWidth() const;
  QPen whiskerPen() const;
  QPen whiskerBarPen() const;
  bool whiskerAntialiased() const;
  QPen medianPen() const;
  QCPScatterStyle outlierStyle() const;

  // setters:
  void setData(QCPStatisticalBoxDataContainer *data);
  %MethodCode
    sipCpp->setData(QSharedPointer<QCPStatisticalBoxDataContainer>(a0));
  %End
  void setData(const QVector<double> &keys, const QVector<double> &minimum, const QVector<double> &lowerQuartile, const QVector<double> &median, const QVector<double> &upperQuartile, const QVector<double> &maximum, bool alreadySorted=false);
  void setWidth(double width);
  void setWhiskerWidth(double width);
  void setWhiskerPen(const QPen &pen);
  void setWhiskerBarPen(const QPen &pen);
  void setWhiskerAntialiased(bool enabled);
  void setMedianPen(const QPen &pen);
  void setOutlierStyle(const QCPScatterStyle &style);
  
  // non-property methods:
  void addData(const QVector<double> &keys, const QVector<double> &minimum, const QVector<double> &lowerQuartile, const QVector<double> &median, const QVector<double> &upperQuartile, const QVector<double> &maximum, bool alreadySorted=false);
  void addData(double key, double minimum, double lowerQuartile, double median, double upperQuartile, double maximum, const QVector<double> &outliers=QVector<double>());
  
  // reimplemented virtual methods:
  virtual QCPDataSelection selectTestRect(const QRectF &rect, bool onlySelectable) const;
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  virtual QCPRange getKeyRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth) const;
  virtual QCPRange getValueRange(bool &foundRange, QCP::SignDomain inSignDomain=QCP::sdBoth, const QCPRange &inKeyRange=QCPRange()) const;

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual void drawLegendIcon(QCPPainter *painter, const QRectF &rect) const;

  // introduced virtual methods:
//   virtual void drawStatisticalBox(QCPPainter *painter, QCPStatisticalBoxDataContainer::const_iterator it, const QCPScatterStyle &outlierStyle) const;

  // non-virtual methods:
//   void getVisibleDataBounds(QCPStatisticalBoxDataContainer::const_iterator &begin, QCPStatisticalBoxDataContainer::const_iterator &end) const;
//   QRectF getQuartileBox(QCPStatisticalBoxDataContainer::const_iterator it) const;
//   QVector<QLineF> getWhiskerBackboneLines(QCPStatisticalBoxDataContainer::const_iterator it) const;
//   QVector<QLineF> getWhiskerBarLines(QCPStatisticalBoxDataContainer::const_iterator it) const;
};
